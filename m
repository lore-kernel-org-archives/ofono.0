Content-Type: multipart/mixed; boundary="===============1941344064666286258=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] plugins: Add Gemalto plugin for Cinterion P-family
Date: Mon, 16 Jan 2017 21:50:43 -0600
Message-ID: <4555dafb-46ca-1921-4e27-28c167a519b6@gmail.com>
In-Reply-To: <1484557673-15666-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1941344064666286258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 01/16/2017 03:07 AM, Vincent Cesson wrote:
> Actual cinterion plugin is not compliant with newer Gemalto modems.
> Gemalto plugin is based on cinterion with a custom struct to handle the
> interfaces Application and Modem.
> ---
>  Makefile.am       |   3 +
>  plugins/gemalto.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 267 insertions(+)
>  create mode 100644 plugins/gemalto.c
>


When applied, I got the following compile error:

plugins/gemalto.c: In function =E2=80=98gemalto_pre_sim=E2=80=99:
plugins/gemalto.c:197:2: error: implicit declaration of function =

=E2=80=98ofono_location_reporting_create=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
   ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
   ^

I'm guessing you have some location reporting patches forthcoming. =

Anyway, I took out the offending line (please add it in your patch =

series dealing with location reporting) and pushed upstream.

Regards,
-Denis

--===============1941344064666286258==--

