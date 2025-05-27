# 27052025

Ok so my logic after looking at the task is the following : 

I will use modules from tf repo because that's how I would do it in real life - will try to keep the resource blocks to minimal

For lambda function a simple python script using boto3 library will do


Lambda will have to access s3 and it will be in private vpc so I will use a vpc endpoint for that

Of course permissions to access bucket - will give in the role

I see here deployment process and automation

I might do a simple cicd pipeline for the terraform code I create that will always run a plan,fmt,validate and allow me run apply on main branch depending on how I am with time

Ok this is my first commit - let's go I will try my commits to be documentation



I have just tested uploading an image and it works - will put that image to repo 

Just run : 

curl -X POST APIURL -H "Content-Type: application/json" -d @payload.json

CICD I will  just discuss during interview but it would be pretty standard plan trigger on upload , apply triggered on merge with manual approval

by the way yes I know - should have used remote backed and give access to my github workflow to that bucket by setting up secrets in the repository  - trust me I know 

in my head it's enough that I know that I needed to do it and can do it / talk about it 

also I started this task at 5:30 today and it's 7:12 - I think 1.5hr of effort is fair enough

thank you !
