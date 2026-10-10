#!/usr/bin/env python3
"""Copies shared design assets into the app, resized for mobile.

* hero/onboarding photos  -> assets/images/ (1200 px wide)
* backend seed car photos -> assets/images/vehicles/ (900 px wide, used by mock mode)
* writes assets/CREDITS.md from shared/design/assets/CREDITS.md and the
  seed manifest (Unsplash License; photographer + photo URL per image).

Run from the app root: python3 tool/sync_design_assets.py
"""
import json, os, shutil, subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SHARED = os.path.join(ROOT, '..', 'shared', 'design', 'assets')
SEED = os.path.join(ROOT, '..', 'rove-backend', 'seed-assets', 'vehicles')
OUT = os.path.join(ROOT, 'assets', 'images')

HEROES = {
    'welcome_hero.jpg': 'hero-night-road-1.jpg',
    'onboarding_1.jpg': 'hero-dark-car-1.jpg',
    'onboarding_2.jpg': 'hero-dark-car-2.jpg',
    'onboarding_3.jpg': 'hero-dark-car-3.jpg',
}


def resize(src, dst, width):
    shutil.copyfile(src, dst)
    subprocess.run(['sips', '-Z', str(width), '-s', 'formatOptions', '75', dst],
                   check=True, stdout=subprocess.DEVNULL)


os.makedirs(os.path.join(OUT, 'vehicles'), exist_ok=True)
for dst, src in HEROES.items():
    resize(os.path.join(SHARED, src), os.path.join(OUT, dst), 1200)

manifest = json.load(open(os.path.join(SEED, 'manifest.json')))
rows = []
for photos in manifest['vehicles'].values():
    for p in photos:
        resize(os.path.join(SEED, p['file']), os.path.join(OUT, 'vehicles', p['file']), 900)
        rows.append(f"| `images/vehicles/{p['file']}` | [{p['photoUrl']}]({p['photoUrl']}) | Photo by {p['photographer']} on Unsplash |")

hero_credits = open(os.path.join(SHARED, 'CREDITS.md')).read()
with open(os.path.join(ROOT, 'assets', 'CREDITS.md'), 'w') as f:
    f.write('# Image credits\n\nAll photos are from Unsplash under the free Unsplash License '
            '(https://unsplash.com/license). Plus Jakarta Sans is under the SIL OFL 1.1 '
            '(fonts/OFL.txt).\n\n## Hero and onboarding (copied from shared/design/assets)\n\n')
    f.write('Mapping: ' + ', '.join(f'`{d}` ← `{s}`' for d, s in HEROES.items()) + '\n\n')
    f.write(hero_credits.split('\n', 2)[2] if hero_credits.startswith('#') else hero_credits)
    f.write('\n\n## Vehicle photos (mock mode; same files as the backend seed)\n\n'
            '| File | Photo | Credit |\n|---|---|---|\n' + '\n'.join(rows) + '\n')
print('ok', len(rows), 'vehicle photos')
