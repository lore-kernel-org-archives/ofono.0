Content-Type: multipart/mixed; boundary="===============0596186869092715304=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmi: remove request when it timeouts
Date: Mon, 30 Oct 2017 09:04:23 -0500
Message-ID: <7ae9bd7f-93c0-c929-ef97-1182a0c1c7ef@gmail.com>
In-Reply-To: <1509115037-18275-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0596186869092715304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 10/27/2017 09:37 AM, Christophe Ronco wrote:
> When modem does not answer or answers slowly to a discovery request,
> a timeout occurs.
> In timeout callback, request should be removed from queues to avoid
> treating answer if it arrives later.
> ---
>   drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============0596186869092715304==--

