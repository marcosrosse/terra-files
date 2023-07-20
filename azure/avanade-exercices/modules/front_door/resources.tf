resource "random_id" "app_name" {
  byte_length = 8
}

resource "random_id" "front_door_endpoint_name" {
  byte_length = 8
}