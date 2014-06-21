Content-Type: multipart/mixed; boundary="===============1868006746543861111=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/5] Add support for PAP authentication
Date: Sat, 21 Jun 2014 12:11:09 -0500
Message-ID: <53A5BCAD.9090707@gmail.com>
In-Reply-To: <1403172429-26289-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1868006746543861111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 06/19/2014 05:07 AM, Philip Paeps wrote:
> Changes since v1:
> =

>  o Split patchset into a commit per directory
>  o Remove Signed-off-by: tags
>  o Fix coding style nits
>  o Use a counter instead of a random value for the
>    Authenticate-Request identifer
>  o Omit the provisioning code pending a discussion with
>    the mobile-broadband-provider-info maintainers
> =

> Philip Paeps (5):
>   gatchat: implement PAP authentication
>   include: add auth method to the gprs context API
>   atmodem: set the PPP authentication method to use
>   gprs: make PPP authentication method configurable
>   doc: describe the AuthenticationMethod property
> =

>  doc/connman-api.txt            |    4 ++
>  drivers/atmodem/gprs-context.c |   14 ++++
>  gatchat/gatppp.c               |   50 ++++++++++++++-
>  gatchat/gatppp.h               |    8 +++
>  gatchat/ppp.h                  |    9 +++
>  gatchat/ppp_auth.c             |  139 ++++++++++++++++++++++++++++++++++=
++++++
>  gatchat/ppp_lcp.c              |   62 ++++++++++++------
>  include/gprs-context.h         |    6 ++
>  src/gprs.c                     |   84 ++++++++++++++++++++++++
>  9 files changed, 355 insertions(+), 21 deletions(-)
> =


All patches in this series have been applied, thanks!  I did fix up a
couple of very minor coding style issues; just being nitpicky.

It was refreshing to review something this well prepared :)

Regards,
-Denis

--===============1868006746543861111==--

