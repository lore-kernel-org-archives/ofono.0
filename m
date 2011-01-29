Content-Type: multipart/mixed; boundary="===============6212624345988174828=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 0/3] Persist TX SMS messages
Date: Fri, 28 Jan 2011 20:38:36 -0600
Message-ID: <4D437DAC.1040506@gmail.com>
In-Reply-To: <1296182397-31963-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6212624345988174828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 01/27/2011 08:39 PM, Lucas De Marchi wrote:
> Third version. It includes some changes suggested by Denis:
> =

> - Get rid of the oldpath field in struct txq_backup_entry
> - Store the encoded uuid in struct txq_backup_entry
> - Use SMS_MSGID_FMT to get the file name
> - Some more cleanups
> =

> Lucas De Marchi (3):
>   sms: store pending tx pdus on disk
>   sms: delete sent sms messages from backup
>   sms: restore pending tx messages from backup
> =

>  src/ofono.h   |    1 +
>  src/sms.c     |   91 ++++++++++++++++++++
>  src/smsutil.c |  257 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/smsutil.h |   17 ++++
>  4 files changed, 366 insertions(+), 0 deletions(-)
> =


I applied all three patches but refactored patch 3 afterwards.  In my
testing everything seems to be working nicely and I went ahead and
marked the TODO item as done.  Please review my changes to make sure I
didn't break anything.

Regards,
-Denis

--===============6212624345988174828==--

