Content-Type: multipart/mixed; boundary="===============6060107896549087368=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/11] Support for concatenated SMS status report. And
 ofono_history_sms is now updated according to received status reports.
Date: Fri, 28 May 2010 12:26:41 -0500
Message-ID: <201005281226.41699.denkenz@gmail.com>
In-Reply-To: <1274957690-4893-9-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6060107896549087368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> From: Pasi Miettinen <pasi.miettinen@ixonos.com>
> =

> ---
>  include/history.h |    2 +
>  src/sms.c         |  157
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++- src/smsutil.h     =

| =

>    6 ++
>  3 files changed, 163 insertions(+), 2 deletions(-)
> =


Some general comments:

I'd like to see a status_report assembly similar to how the sms_assembly is =

done.  This should exist in smsutil.c/.h so that we can easily unit test th=
is =

functionality (which I would also like to see.)

Another desirable feature for the status report assembly is to save off the =

status report fragments on disk, so that status reports (for multi-fragment =

SMSes) received across oFono / system reboots and crashes are handled =

appropriately.

Regards,
-Denis

--===============6060107896549087368==--

