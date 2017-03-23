Content-Type: multipart/mixed; boundary="===============6165970583147404063=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/5] qmimodem: read ss_info at probe time
Date: Thu, 23 Mar 2017 10:32:45 -0500
Message-ID: <d0232898-3de9-49bb-d424-1b58fe29c5e9@gmail.com>
In-Reply-To: <1490206493-17454-3-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6165970583147404063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/22/2017 01:14 PM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> LTE modems (observed with Telit LE910 V1) can power on
> already registered to a network. In that case, the SS_INFO
> change notification will never arrive, and the gprs driver
> will never be marked as attached.
>
> To avoid this situation, read SS_INFO at probe time, and if
> registered, mark the gprs driver as attached.
> ---
>  drivers/qmimodem/gprs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============6165970583147404063==--

