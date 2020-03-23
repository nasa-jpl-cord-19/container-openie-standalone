# openie-standalone

Containerized version of https://github.com/dair-iitd/OpenIE-standalone.

## Before building

Make sure you have enough diskspace, time, and compute power. This thing is a ridiculous beast. Gather the dependencies (~8GB worth) with `./download-dependencies.sh`.

## Build

Nothing special here.

```bash
docker build --rm --tag openie-standalone .
```

## Running locally

Attempt at mirroring the constraints enforced in "production".

```bash
docker run --read-only=true --cap-drop=all --rm --user="31002:31002" -it -p 8182:8182 openie-standalone
```

## Verify it is working

```bash
$ curl -X POST localhost:8182/getExtraction -d 'The Jet Propulsion Laboratory is a federally funded research and development center and NASA field center in the city of La Canada Flintridge with a Pasadena mailing address, within the state of California, United States.'
[{"confidence":0.5444088301032625,"sentence":"The Jet Propulsion Laboratory is a federally funded research and development center and NASA field center in the city of La Canada Flintridge with a Pasadena mailing address, within the state of California, United States.","extraction":{"arg1":{"text":"federally","offsets":[[35,36,37,38,39,40,41,42,43]]},"rel":{"text":"funded","offsets":[[45,46,47,48,49,50]]},"arg2s":[{"text":"research and development center","offsets":[[52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82]]}],"context":null,"negated":false,"passive":false}},{"confidence":0.9531084046451801,"sentence":"The Jet Propulsion Laboratory is a federally funded research and development center and NASA field center in the city of La Canada Flintridge with a Pasadena mailing address, within the state of California, United States.","extraction":{"arg1":{"text":"The Jet Propulsion Laboratory","offsets":[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]]},"rel":{"text":"is","offsets":[[30,31]]},"arg2s":[{"text":"a federally funded research and development center","offsets":[[33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82]]}],"context":null,"negated":false,"passive":true}}]
```