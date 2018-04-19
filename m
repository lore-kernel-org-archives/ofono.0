Content-Type: multipart/mixed; boundary="===============7539648087989239279=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmi: use right slot and application during SIM
 detection
Date: Thu, 19 Apr 2018 10:25:14 -0500
Message-ID: <58dc7a1d-8929-59e6-3698-688b62589a82@gmail.com>
In-Reply-To: <1524126706-16730-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7539648087989239279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 04/19/2018 03:31 AM, Christophe Ronco wrote:
> Use right slot and application to get card status, PIN status and PIN
> retries. Without this patch, SIMs where selected application and slot
> numbers are different are not detected.
> ---
>   drivers/qmimodem/sim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============7539648087989239279==--

