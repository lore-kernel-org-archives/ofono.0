Content-Type: multipart/mixed; boundary="===============1723513307930210478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmi: support SMS receive on Quectel EC21
Date: Tue, 17 Oct 2017 09:35:48 -0500
Message-ID: <4c7306d6-a8da-7bb6-3c58-4019e9079388@gmail.com>
In-Reply-To: <20171016122048.2405-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1723513307930210478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/16/2017 07:20 AM, Jonas Bonn wrote:
> The Quectel EC21 does not provide the SMS PDU on the message event
> notification.
> =

> This patch adds a call to 'raw read' on the message ID from the event
> notification if the event notification does not already contain the
> message data.
> =

> The message data begins with the SMSC length, type, and address so
> the TPDU length is adjusted accordingly in the raw_read callback.  This
> differs from the way the raw message data is handled in the case
> that it is included in the event notification itself.  As I don't have
> access to any other QMI modem at this time, I'm can not confirm that
> this difference is reasonable.
> ---
>   drivers/qmimodem/sms.c | 57 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   drivers/qmimodem/wms.h |  9 ++++++++
>   2 files changed, 66 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============1723513307930210478==--

