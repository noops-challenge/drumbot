## drumbot API


### Get all patterns

`GET https://api.noopschallenge.com/drumbot/patterns`

`HTTP 200`

```
[
  { "name": "oontza" },
  { "name": "bossanoopa" },
  { "name": "nipnop" },
  { "name": "botthisway" },
  { "name": "funkee" },
  { "name": "shlojam" },
  { "name": "botorik" },
  { "name": "swoop" },
  { "name": "schmaltz" },
  { "name": "bouncy" }
]
```


### Get a single pattern

`GET https://api.noopschallenge.com/drumbot/patterns/nipnop`

`HTTP 200`

```
{
  "name": "nipnop",
  "stepCount": 16,
  "beatsPerMinute": 92,
  "tracks": [
    {
      "instrument": "snare",
      "steps": [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ]
    },
    {
      "instrument": "clap",
      "steps": [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 ]
    },
    {
      "instrument": "cowbell",
      "steps": [ 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0 ]
    },
    {
      "instrument": "kick",
      "steps": [ 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ]
    }
  ]
}
```
