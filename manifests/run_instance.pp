# docker_config::run_instances
class docker_config::run_instance($instances) {
  create_resources(docker_config::run, $instances)
}