# 
# docker_config::run
# 

# $detach: value "default" will be changed to undef, "true" => true and 'false' => false, see docker::run for details

define docker_config::run(
    $image,
    $command = 'false',
    $memory_limit = '0b',
    $cpuset = '',
    $ports = '',
    $expose = '',
    $volumes = '',
    $links = '',
    $use_name = 'false',
    $running = 'true',
    $volumes_from = '',
    $net = 'bridge',
    $username = 'false',
    $hostname = 'false',
    $env = '',
    $env_file = '',
    $dns = '',
    $dns_search = '',
    $lxc_conf = '',
    $restart_service = 'true',
    $disable_network = 'false',
    $privileged = 'false',
    $detach = 'default',
    $extra_parameters = 'false',
    $pull_on_start = 'false',
    $depends = '',
    $tty = 'false',
    $socket_connect = '',
    $hostentries = '',
    $restart = 'false',
){
    include docker_config
    
    if ($hostentries == ''){
        $real_hostentries = []
    } else {
        $real_hostentries = $hostentries
    }

    if ($socket_connect == ''){
        $real_socket_connect = []
    } else {
        $real_socket_connect = $socket_connect
    }

    if ($depends == ''){
        $real_depends = []
    } else {
        $real_depends = $depends
    }

    if ($lxc_conf == ''){
        $real_lxc_conf = []
    } else {
        $real_lxc_conf = $lxc_conf
    }

    if ($dns_search == ''){
        $real_dns_search = []
    } else {
        $real_dns_search = $dns_search
    }

    if ($dns == ''){
        $real_dns = []
    } else {
        $real_dns = $dns
    }

    if ($env_file == ''){
        $real_env_file = []
    } else {
        $real_env_file = $env_file
    }

    if ($env == ''){
        $real_env = []
    } else {
        $real_env = $env
    }

    if ($volumes_from == ''){
        $real_volumes_from = []
    } else {
        $real_volumes_from = $volumes_from
    }

    if ($links == ''){
        $real_links = []
    } else {
        $real_links = $links
    }
    
    if ($volumes == ''){
        $real_volumes = []
    } else {
        $real_volumes = $volumes
    }

    if ($expose == ''){
        $real_expose = []
    } else {
        $real_expose = $expose
    }

    if ($ports == ''){
        $real_ports = []
    } else {
        $real_ports = $ports
    }

    if ($cpuset == ''){
        $real_cpuset = []
    } else {
        $real_cpuset = $cpuset
    }

    $real_tty = str2bool($tty)
    $real_pull_on_start = str2bool($pull_on_start)
    $real_privileged = str2bool($privileged)
    $real_restart_service = str2bool($restart_service)
    $real_disable_network = str2bool($disable_network)
    
    if ($hostname == 'false'){
        $real_hostname = false
    } else {
        $real_hostname = $hostname
    }
    
    if ($username == 'false'){
        $real_username = false
    } else {
        $real_username = $username
    }

    $real_running = str2bool($running)
    $real_use_name = str2bool($use_name)

    if ($restart == 'false'){
        $real_restart = undef
    } else {
        $real_restart = $restart
    }

    if ($extra_parameters == 'false'){
        $real_extra_parameters = undef
    } else {
        $real_extra_parameters = $extra_parameters
    }

    if ($command == 'false'){
        $real_command = undef
    } else {
        $real_command = $command
    }

    if ($detach == 'default'){
        $real_detach = undef
    } else {
        $real_detach = str2bool($detach)
    }

    docker::run{ $name:
        image            => $image,
        command          => $real_command,
        memory_limit     => $memory_limit,
        cpuset           => $real_cpuset,
        ports            => $real_ports,
        expose           => $real_expose,
        volumes          => $real_volumes,
        links            => $real_links,
        use_name         => $real_use_name,
        running          => $real_running,
        volumes_from     => $real_volumes_from,
        net              => $net,
        username         => $real_username,
        hostname         => $real_hostname,
        env              => $real_env,
        env_file         => $real_env_file,
        dns              => $real_dns,
        dns_search       => $real_dns_search,
        lxc_conf         => $real_lxc_conf,
        restart_service  => $real_restart_service,
        disable_network  => $real_disable_network,
        privileged       => $real_privileged,
        detach           => $real_detach,
        extra_parameters => $real_extra_parameters,
        pull_on_start    => $real_pull_on_start,
        depends          => $real_depends,
        tty              => $real_tty,
        socket_connect   => $real_socket_connect,
        hostentries      => $real_hostentries,
        restart          => $real_restart,
    }
}