Content-Type: multipart/mixed; boundary="===============3238299982072128248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Accept WAP push notifications with any origin port
Date: Tue, 08 Sep 2015 09:14:31 -0500
Message-ID: <55EEED47.20109@gmail.com>
In-Reply-To: <1441619897-22899-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3238299982072128248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 09/07/2015 04:58 AM, Alfonso Sanchez-Beato wrote:
> Accept WAP push notifications regardless of the origin port, as some
> operators seem to use random ports. The destination port is enough to
> route properly the message.
>
> Alfonso Sanchez-Beato (3):
>    push-notification: Accept push from any origin
>    smsutil: Do not check the origin port
>    sms: Add trace when datagram is not delivered
>
>   plugins/push-notification.c | 25 +++++++------------------
>   src/sms.c                   |  7 +++++++
>   src/smsutil.c               |  3 ---
>   3 files changed, 14 insertions(+), 21 deletions(-)
>

All 3 patches have been applied.  Thanks!

Regards,
-Denis

--===============3238299982072128248==--

