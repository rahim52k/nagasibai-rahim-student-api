# Nagasibai Rahim Student API

Personalized DevOps midterm project: Spring Boot CRUD API with PostgreSQL, Docker Compose, Git workflow, and Jenkins pipeline.

Student: **Nagasibai Rahim**

## API endpoints

Base URL: `http://localhost:8080/api/students`

- `POST /api/students` — create a student
- `GET /api/students` — list students
- `GET /api/students/{id}` — retrieve one student
- `PUT /api/students/{id}` — update a student
- `DELETE /api/students/{id}` — delete a student
- Unknown IDs return HTTP 404.

Example JSON:
```json
{
  "fullName": "Nagasibai Rahim",
  "email": "nagasibai.rahim@example.com",
  "course": "DevOps"
}
```

## Run with Docker Compose

Requirements: Docker Desktop (Windows/Mac) or Docker Engine + Compose plugin (Linux), and Git.

1. In a terminal, go to this project folder.
2. Optional: copy `.env.example` to `.env` and change the local password.
3. Run `docker compose -p nagasibai-rahim-student-api up --build -d`.
4. Check `docker compose ps` and `docker compose logs app`.
5. API is available at `http://localhost:8080/api/students`.
6. Stop with `docker compose down`. The named PostgreSQL volume remains. To remove data intentionally, use `docker compose down -v`.

The application connects to host `db` because that is the Compose service name, not `localhost`.

## Linux Part 1

From the project directory on Linux/WSL:
```bash
mkdir -p scripts logs backups src
touch Dockerfile docker-compose.yml Jenkinsfile build.gradle README.md
touch logs/Nagasibai_Rahim_system_report.log
chmod +x scripts/Nagasibai_Rahim_system_report.sh
chmod 744 scripts/Nagasibai_Rahim_system_report.sh
./scripts/Nagasibai_Rahim_system_report.sh
cp README.md backups/README_Nagasibai_Rahim.md
ls -l scripts/Nagasibai_Rahim_system_report.sh logs/Nagasibai_Rahim_system_report.log backups/README_Nagasibai_Rahim.md
tail -n 5 logs/Nagasibai_Rahim_system_report.log
grep -i 'Rahim' logs/Nagasibai_Rahim_system_report.log > Nagasibai_Rahim_log_analysis.txt
ps aux | grep -i '[j]ava'
find . -maxdepth 2 -print | sort
```
`744` gives the owner read/write/execute and group/others read-only. The script creates the log on execution and replaces its content each run. For append-only reporting, replace `tee "$LOG_FILE"` with `tee -a "$LOG_FILE"`.

`>` creates/overwrites a file; `>>` appends to it.

## Git and GitHub Part 2

Run in the project directory:
```bash
git init
git config user.name "Nagasibai Rahim"
git config user.email "YOUR_GITHUB_EMAIL"
git add .
git commit -m "Initial commit: Nagasibai Rahim Student API"
git branch -M main
git switch -c feature/nagasibai-rahim-crud
```
Make a meaningful change to the CRUD code or README and commit it twice, for example:
```bash
git add README.md
git commit -m "Document Nagasibai Rahim student CRUD API"
# Make a second real improvement, then:
git add .
git commit -m "Improve Nagasibai Rahim API handling"
git switch main
git merge feature/nagasibai-rahim-crud
```

Conflict demonstration (use a practice branch and keep the changes):
```bash
git switch -c feature/nagasibai-rahim-documentation
# Edit the same README line and commit:
git add README.md
git commit -m "Update Nagasibai Rahim documentation"
git switch main
# Edit that exact same line differently and commit:
git add README.md
git commit -m "Revise Nagasibai Rahim project summary"
git merge feature/nagasibai-rahim-documentation
# Resolve <<<<<<<, =======, >>>>>>> markers in README.md manually:
git add README.md
git commit -m "Resolve README conflict for Nagasibai Rahim"
git log --oneline --graph --all
```
Create an empty GitHub repository named `nagasibai-rahim-student-api`, then use its actual URL:
```bash
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/nagasibai-rahim-student-api.git
git push -u origin main
git push -u origin --all
git tag v1.0-rahim
git push origin v1.0-rahim
git remote -v
git branch -a
git tag
git log --oneline --graph --decorate --all
```
Do not commit `.env`, passwords, or database credentials because repository history may expose them. Use environment variables or Jenkins Credentials.

## Docker evidence (Part 3)

```bash
docker build -t nagasibai-rahim-student-api:v1.0-rahim .
docker image inspect nagasibai-rahim-student-api:v1.0-rahim --format='Size={{.Size}} Created={{.Created}}'
docker compose -p nagasibai-rahim-student-api up --build -d
docker ps
docker compose logs app
docker inspect nagasibai-rahim-app
docker exec -it nagasibai-rahim-app sh
docker compose stop app
docker compose start app
docker compose up --build -d
```

CRUD test examples using curl (Windows PowerShell can use `curl.exe`):
```bash
curl -i -X POST http://localhost:8080/api/students -H "Content-Type: application/json" -d '{"fullName":"Nagasibai Rahim","email":"nagasibai.rahim@example.com","course":"DevOps"}'
curl -i http://localhost:8080/api/students
curl -i http://localhost:8080/api/students/1
curl -i -X PUT http://localhost:8080/api/students/1 -H "Content-Type: application/json" -d '{"fullName":"Nagasibai Rahim","email":"nagasibai.rahim@example.com","course":"Linux and DevOps"}'
curl -i -X DELETE http://localhost:8080/api/students/1
curl -i http://localhost:8080/api/students/999999
```
Use the ID actually returned by POST rather than assuming it is `1`. Expected status codes: create `201`, reads/update `200`, delete `204`, missing record `404`.

To demonstrate persistence: create a student, run `docker compose down`, then `docker compose up -d`; query the list again. Do not use `docker compose down -v` during this test.

## Jenkins Part 4

Use a Jenkins agent that has Java 21, Gradle, Git, and Docker CLI/daemon access. Create a Pipeline job named `Nagasibai_Rahim_Student_API`, point it at your GitHub repository, and select “Pipeline script from SCM” with script path `Jenkinsfile`. Ensure the agent supports Linux `sh` steps. For a private repository, configure a GitHub credential in Jenkins Credentials and select it in the job. Configure a GitHub webhook or polling trigger in the job.

To demonstrate failure safely, create a temporary test branch, intentionally make a test fail, run the pipeline and capture the failed result, then revert the deliberate change and rerun until green. Never introduce the deliberate failure into a production/shared branch.

## Defense notes

- Docker image: immutable template used to create containers; container: running or stopped instance of an image.
- Git: version-control tool; GitHub: hosted platform for Git repositories.
- `git add`: stage changes; `git commit`: save a snapshot; `git push`: send commits to remote.
- Branch: isolated line of work. Merge conflict: Git cannot automatically reconcile overlapping edits.
- Docker Compose: defines and runs related services. Volume: persists database data beyond container recreation. Network: lets services discover each other by service name.
- Dockerfile `RUN` executes at build time; `CMD` supplies the default runtime command. `COPY` copies files; `ADD` also supports extra archive/URL behavior, so `COPY` is preferred for simple copies.
- Jenkinsfile: pipeline-as-code. Checkout fetches source; Build compiles/packages; Test runs automated tests. A failing test command returns a nonzero exit code and fails the stage/pipeline.
- CI integrates and tests changes frequently. Continuous Delivery keeps software deployable; Continuous Deployment automatically releases qualifying changes.
- `df -h` reports disk space; `free -h` reports memory; `tail -n 5 file` shows the last five lines; `chmod 744 file` gives owner `rwx` and group/others `r`.
- `>` overwrites output; `>>` appends output. `mkdir -p` creates missing parent directories without error if they already exist.

## CRUD Operations

The Student API supports the following operations:
- Create a student
- Retrieve all students
- Retrieve a student by ID
- Update student information
- Delete a student

## Developer

Nagasibai Rahim