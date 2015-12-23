# docker_config::images
class docker_config::images($images) {
  create_resources(docker_config::image, $images)
}