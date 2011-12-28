Content-Type: multipart/mixed; boundary="===============1250305473534735347=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] gprs: Use netreg SPN watch API
Date: Wed, 28 Dec 2011 16:14:34 -0600
Message-ID: <4EFB94CA.1000001@gmail.com>
In-Reply-To: <1325078324-30548-4-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1250305473534735347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 12/28/2011 07:18 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/gprs.c |   67 ++++++++++++++++++++++++++++++++----------------------=
-----
>  1 files changed, 36 insertions(+), 31 deletions(-)
> =


So I like this approach, the only problem is that netreg atom is a
post_online atom and gprs is post_sim atom.  This means that if no
contexts are provisioned we must wait for the netreg atom to be
registered.  This leads to a slight asymmetry in the API.

Perhaps we should move the SPN logic to the sim atom and make netreg and
gprs atom simple consumers?

Regards,
-Denis

--===============1250305473534735347==--

