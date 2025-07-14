import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as ecr from 'aws-cdk-lib/aws-ecr';
// import * as ecr from 'aws-cdk-lib/aws-ecr';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
// import { Construct } from 'constructs';


import * as ecs from 'aws-cdk-lib/aws-ecs';
import * as ecs_patterns from 'aws-cdk-lib/aws-ecs-patterns';

// import * as sqs from 'aws-cdk-lib/aws-sqs';
    // Import existing VPC by ID and subnet IDs
    export class CdkStack extends cdk.Stack {
      constructor(scope: Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props);
    
    const vpc = ec2.Vpc.fromVpcAttributes(this, 'ImportedVpc', {
      vpcId: 'vpc-0b4e09447bfcf30d1',
      availabilityZones: ['eu-central-1a', 'eu-central-1b', 'eu-central-1c'], // fill with your AZs
      privateSubnetIds: [
        'subnet-021b2ed6f4de290de',
        'subnet-079267ac592762dd3',
        'subnet-0bc3438573132a1de',
      ],
      publicSubnetIds: [
        'subnet-049030f446189d56f',
        'subnet-0beadca19ba07e312',
        'subnet-05548cf3f6320b827',
      ],
      // You can add isolatedSubnetIds if you have any
    });



    // Import the existing repo
    const repo = ecr.Repository.fromRepositoryName(this, 'FlaskEcrRepo', 'flask-api-repo-v2');
    const cluster = new ecs.Cluster(this, 'EcsCluster', { vpc });
    new ecs_patterns.ApplicationLoadBalancedFargateService(this, 'FlaskServiceDev', {
      cluster,
      taskImageOptions: {
        image: ecs.ContainerImage.fromEcrRepository(repo, 'latest'),
        containerPort: 5000,
      },
      desiredCount: 2,
      publicLoadBalancer: true,
    });
    const taskDef = new ecs.FargateTaskDefinition(this, 'TaskDef', {
      memoryLimitMiB: 512,
      cpu: 256,
    });

    taskDef.addContainer('FlaskContainer', {
      image: ecs.ContainerImage.fromEcrRepository(repo, 'latest'),
      portMappings: [{ containerPort: 5000 }],
      essential: true,
    });

    new ecs.FargateService(this, 'FlaskService', {
      cluster,
      taskDefinition: taskDef,
      assignPublicIp: true,
      desiredCount: 1,
      vpcSubnets: {
        subnets: vpc.publicSubnets,
      },
    });

    // const defaultSG = ec2.SecurityGroup.fromSecurityGroupId(
    //   this,
    //   'DefaultSG',
    //   cluster.connections.securityGroups[0].securityGroupId
    // );
    // defaultSG.addIngressRule(ec2.Peer.anyIpv4(), ec2.Port.tcp(5000), 'Allow HTTP to Flask');


    // The code that defines your stack goes here

    // example resource
    // const queue = new sqs.Queue(this, 'CdkQueue', {
    //   visibilityTimeout: cdk.Duration.seconds(300)
    // });
  }
}
