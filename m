Content-Type: multipart/mixed; boundary="===============4556219231884634041=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 0/2] Make message state feature independent of the stack
Date: Thu, 20 Jan 2011 15:02:41 -0600
Message-ID: <4D38A2F1.6010909@gmail.com>
In-Reply-To: <1295559757-22144-1-git-send-email-faiyaz.baxamusa@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4556219231884634041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Faiyaz,

On 01/20/2011 03:42 PM, Faiyaz Baxamusa wrote:
> This set of patches enable the "org.ofono.Message" interface code to be
> independent of the protocol stack. This will enable both GSM and CDMA SMS=
 stack
> to reuse the interface code.
> =

> The changes have been tested with phonesim using send-sms script.
> =

> Faiyaz Baxamusa (2):
>   doc: Add messagemanager-api and change message-api
>   sms: Introduce message code independent of protocol stack
> =

>  Makefile.am                                        |    7 +-
>  ...message-api.txt =3D> cdma-messagemanager-api.txt} |    0
>  doc/message-api.txt                                |   89 -------
>  doc/messagemanager-api.txt                         |   88 +++++++
>  src/message.c                                      |  228 ++++++++++++++=
++++
>  src/message.h                                      |   54 +++++
>  src/sms.c                                          |  247 +++-----------=
------
>  7 files changed, 402 insertions(+), 311 deletions(-)
>  rename doc/{cdma-message-api.txt =3D> cdma-messagemanager-api.txt} (100%)
>  create mode 100644 doc/messagemanager-api.txt
>  create mode 100644 src/message.c
>  create mode 100644 src/message.h

Both patches have been applied, thanks.

Regards,
-Denis

--===============4556219231884634041==--

