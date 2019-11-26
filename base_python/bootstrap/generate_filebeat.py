#!/bootstrap_env/bin/python
import os
import yaml

from fan_tools.python import rel_path


DEFAULTS = {
    'LOGSTASH_HOST': 'logstash',
    'LOGSTASH_PORT': '5044',
    'HOST_TYPE': 'local',
}

OPTIONAL_PARAMS = ['DEPLOYMENT_CONFIG', 'DEPLOYMENT_BRANCH']


def get_param(name):
    return os.environ.get(name, DEFAULTS.get(name))


def get_fields():
    out = {}
    for field in ['HOST_TYPE', 'DEPLOYMENT_CONFIG', 'DEPLOYMENT_BRANCH']:
        value = get_param(field)
        if value is None:
            # skip OPTIONAL_PARAMS
            assert field in OPTIONAL_PARAMS
        else:
            out[field] = value
    return out


def get_prospectors_dict(conf):
    out = {}
    for p in conf['filebeat']['prospectors']:
        out[p['fields']['source_type']] = p
    return out


def recursive_merge(src, dst):
    if isinstance(src, dict):
        for k, v in src.items():
            if k in dst:
                recursive_merge(v, dst[k])
            else:
                dst[k] = v
    elif isinstance(src, list):
        dst.extend(src)
    elif src == dst:
        pass
    else:
        print(f'Merging: {src} {dst}')
        raise NotImplementedError


def merge_filebeat(fname, conf):
    """
    will modify `conf` dictionary inplace
    """
    with open(fname) as f:
        merge_conf = yaml.load(f)
    original = get_prospectors_dict(conf)
    merge = get_prospectors_dict(merge_conf)
    for k, v in merge.items():
        if k in original:
            recursive_merge(v, original[k])
        else:
            print(f'Append: {k} => {v}')
            conf['filebeat']['prospectors'].append(v)


def main():
    with open(rel_path('./filebeat.tmpl')) as f:
        conf = yaml.load(f)
    conf['fields'].update(get_fields())
    merge_name = os.environ.get('MERGE_FILEBEAT')
    if merge_name and os.path.exists(merge_name):
        merge_filebeat(merge_name, conf)

    if os.environ.get('FILEBEAT_NO_SSL'):
        del conf['output']['logstash']['ssl']

    with open('/filebeat.yml', 'w') as f:
        yaml.dump(conf, f)


if __name__ == '__main__':
    main()
