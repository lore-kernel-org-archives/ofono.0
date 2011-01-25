Content-Type: multipart/mixed; boundary="===============6483451444948425596=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Long phone numbers
Date: Tue, 25 Jan 2011 14:13:27 -0600
Message-ID: <4D3F2EE7.7030809@gmail.com>
In-Reply-To: <1295964158-19223-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6483451444948425596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On 01/25/2011 08:02 AM, Rafael Ignacio Zurita wrote:
> This set of patches extends OFONO_MAX_PHONE_NUMBER_LENGTH, splits
> common:valid_phone_number_format(), and adapts voicecall to valid
> the 80 character limit for outgoing calls.
> =

> Rafael Ignacio Zurita (2):
>   types: change OFONO_MAX_PHONE_NUMBER_LENGTH value to 80
>   common: split valid_phone_number_format and adapt voicecall
> =

>  include/types.h |    2 +-
>  src/common.c    |   20 ++++++++++++++++++--
>  src/common.h    |    2 ++
>  src/voicecall.c |    2 +-
>  4 files changed, 22 insertions(+), 4 deletions(-)
> =


Both patches have been applied, thanks.

Regards,
-Denis

--===============6483451444948425596==--

