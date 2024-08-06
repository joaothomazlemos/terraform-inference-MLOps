module "test_lambdaa" {
    source = "terraform-aws-modules/lambda/aws"
    function_name = "test_lambda"
    description = "A Lambda function for test my knowledge"
    runtime = "python3.10"
    #we will input the source path of the lambda function as the input in the hcl file
    source_path =

}