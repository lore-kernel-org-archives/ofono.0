Content-Type: multipart/mixed; boundary="===============5111837652996519891=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/2] gobi: Do not use low-power modes for some modems
Date: Fri, 24 Mar 2017 10:08:40 -0500
Message-ID: <f4714a58-1ceb-d221-9dbc-642832ce6397@gmail.com>
In-Reply-To: <1490367106-8401-2-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5111837652996519891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/24/2017 09:51 AM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Telit QMI modems have a problem with the low-power operating modes.
> After entering and leaving such a state, UIM service does not return.
> The sim card is still marked as powered-down. The QMI interface does
> not have a way to power it back on.
>
> To avoid this, keep modems with the "AlwaysOnline" flag online
> in the disable-modem and offline-modem procedures.
> ---
>  plugins/gobi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============5111837652996519891==--

