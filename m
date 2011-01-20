Content-Type: multipart/mixed; boundary="===============6678829984148919439=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [offline-atoms PATCHv2] Make gprs atom offline-safe.
Date: Thu, 20 Jan 2011 09:59:25 -0600
Message-ID: <4D385BDD.9070908@gmail.com>
In-Reply-To: <1295530631-21811-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6678829984148919439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 01/20/2011 07:37 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Allow use of GPRS atom both in online and offline (post_sim) states.
> =

> The GPRS now considers the removal of the netreg atom as implicit detach
> and registration change to NOT_REGISTERED.
> ---
>  src/gprs.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============6678829984148919439==--

