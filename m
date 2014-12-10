Content-Type: multipart/mixed; boundary="===============8886548259619489203=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/4] Add AvailableTechnologies property to RadioSettings
Date: Wed, 10 Dec 2014 11:07:48 -0600
Message-ID: <54887DE4.6000701@gmail.com>
In-Reply-To: <1418128479-5491-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8886548259619489203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 12/09/2014 06:34 AM, Alfonso Sanchez-Beato wrote:
> This patch series add the AvailableTechnologies property to the
> RadioSettings interface. Its purpose is to show the list of valid
> values for the TechnologyPreference property in the same interface.
> The use case is letting a UI show the possible RATs so the user cannot
> select an invalid value for a given modem.
>
> Alfonso Sanchez-Beato (4):
>    doc: Add AvailableTechnologies property
>    include: Add method to list RATs to radio-settings
>    src: Implement RAT list property
>    test: Add AvailableTechnologies to list-modems
>
>   doc/radio-settings-api.txt |  5 +++++
>   include/radio-settings.h   | 15 +++++++++++++++
>   src/radio-settings.c       | 47 +++++++++++++++++++++++++++++++++++++++=
++++++-
>   test/list-modems           |  3 ++-
>   4 files changed, 68 insertions(+), 2 deletions(-)
>

I went ahead and applied all four patches.  However, I did tweak =

include/radio-settings.h and src/radio-settings.c afterwards.

Mostly I changed radio_access_mode into a bit field and future-proofed =

the implementation some.  I think it is quite simpler now.

As a bonus I added a minimalistic radio_settings driver to phonesim and =

caught one or two issues along the way.

If I broke something, please let me know.

Regards,
-Denis

--===============8886548259619489203==--

