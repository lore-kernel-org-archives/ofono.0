Content-Type: multipart/mixed; boundary="===============1644502178259097445=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/4] Add bus name to signal watches
Date: Mon, 02 Jul 2012 11:07:02 -0500
Message-ID: <4FF1C726.7090304@gmail.com>
In-Reply-To: <1340891961-9809-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1644502178259097445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 06/28/2012 08:59 AM, Lucas De Marchi wrote:
> First patch is just one that was still pending locally. The other ones fi=
x the
> calls to g_dbus_add_signal_watch() to actually watch only the desired bus=
. It
> depends on previous patch for gdbus to be applied first, otherwise libdbu=
s may
> call abort() when we exit.
>
> Lucas De Marchi (4):
>    README: add information about mailing list and site
>    bluetooth: watch for signals only on BLUEZ_SERVICE
>    stemgr: watch for signals only on MGR_SERVICE
>    tools: watch for signals only on OFONO_SERVICE
>
>   README               |  9 +++++++++
>   plugins/bluetooth.c  | 13 ++++++++-----
>   plugins/stemgr.c     |  4 ++--
>   tools/auto-enable.c  | 20 ++++++++++----------
>   tools/huawei-audio.c | 17 +++++++++--------
>   5 files changed, 38 insertions(+), 25 deletions(-)
>

All patches in this series have been pushed, thanks.

Regards,
-Denis

--===============1644502178259097445==--

