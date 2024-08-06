# attempt to recreate the lambda inference module with a local package ( docker image sotred on ecr)
module "lambda_function_container_image" {
    source = "terraform-aws-modules/lambda/aws"

    function_name = "modelInferenceTensorFlow"
    description   = "A Lambda function that performs inference on a TensorFlow model"

    create_package = false

    image_uri = "667854778706.dkr.ecr.us-east-1.amazonaws.com/model-inference-tensorflow:latest"
    package_type = "Image"
    handler = "lambda_function.handler"
    runtime = "python3.10"
    