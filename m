Content-Type: multipart/mixed; boundary="===============6732601232506709739=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] qmi: report failure or retry in case of invalid pin
 type
Date: Thu, 19 Apr 2018 10:30:09 -0500
Message-ID: <476bef94-91fe-b6ef-20ed-b427d3ccb29c@gmail.com>
In-Reply-To: <1523627916-6684-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6732601232506709739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 04/13/2018 08:58 AM, Christophe Ronco wrote:
> QMI_UIM_GET_CARD_STATUS is retried in more error cases
> when trying to get password type.
> In case of failure, driver report an error instead of
> OFONO_SIM_PASSWORD_INVALID. This avoids a crash.
> ---
>   drivers/qmimodem/sim.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis


--===============6732601232506709739==--

