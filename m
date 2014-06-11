Content-Type: multipart/mixed; boundary="===============2860826514531852027=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] test: Adapt voice call test scripts to multi-modem
Date: Tue, 10 Jun 2014 23:37:35 -0500
Message-ID: <5397DD0F.8070501@gmail.com>
In-Reply-To: <1402388837-12816-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2860826514531852027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 06/10/2014 03:27 AM, Alfonso Sanchez-Beato wrote:
> Some tests scripts were not ready to handle situations with more than
> one modem present. This change fixes the scripts that handle voice
> calls.
> ---
>  test/create-multiparty  | 12 +++++++-----
>  test/hangup-active      | 10 ++++++++--
>  test/private-chat       | 17 ++++++++---------
>  test/release-and-answer | 35 ++++++++++++++++++++++++++---------
>  test/release-and-swap   | 35 ++++++++++++++++++++++++++---------
>  5 files changed, 75 insertions(+), 34 deletions(-)
> =


Both patches have been applied, thanks.

Regards,
-Denis

--===============2860826514531852027==--

