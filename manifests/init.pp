class docker_config(){
    # use docker class to include docker
    include docker
    Class['docker::install'] -> Docker_config::Image<||> -> Docker_config::Run<||> -> Docker_config::Exec<||>
}