import dagshub
import mlflow

dagshub.init(repo_owner='gregorywmorris', repo_name='End-to-End-Chest-Cancer-Classification-using-MLflow-DVC', mlflow=True)

with mlflow.start_run():
  mlflow.log_param('parameter name', 'value')
  mlflow.log_metric('metric name', 1)