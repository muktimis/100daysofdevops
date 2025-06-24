from aws_cdk import Stack, RemovalPolicy           # ✅ Import RemovalPolicy from aws_cdk
from aws_cdk import aws_s3 as s3
from aws_cdk import aws_ec2 as ec2
from constructs import Construct
from aws_cdk import aws_lambda as _lambda
from aws_cdk import aws_apigateway as apigw



class MyCdkProjectStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)
        

#     bucket = s3.Bucket(self, "MyFirstBucket",
#     versioned=True,
#     removal_policy=RemovalPolicy.DESTROY,  # <-- Correct
#     auto_delete_objects=True
# )

        hello_lambda = _lambda.Function(self, "HelloHandler",
            runtime=_lambda.Runtime.PYTHON_3_12,
            handler="hello.handler",
            code=_lambda.Code.from_asset("lambda")
        )

        apigw.LambdaRestApi(self, "HelloApi",
            handler=hello_lambda
        )


        # vpc = ec2.Vpc(self, "MyVPC",
        #       max_azs=2
        #     )

        # instance = ec2.Instance(self,"MyEC2Instance",
        #     instance_type=ec2.InstanceType("t2.micro"),
        #     machine_image=ec2.MachineImage.latest_amazon_linux2023(),
        #     vpc=vpc
        #     )
        

        # The code that defines your stack goes here

        # example resource
        # queue = sqs.Queue(
        #     self, "MyCdkProjectQueue",
        #     visibility_timeout=Duration.seconds(300),
        # )
