Content-Type: multipart/mixed; boundary="===============8311908367352868451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/12] qmi: remove unused fields of service_send_data
Date: Thu, 29 Mar 2018 09:53:37 -0500
Message-ID: <52e5ba41-a211-8e9a-7acc-a5f76a2d493b@gmail.com>
In-Reply-To: <20180329135801.5981-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8311908367352868451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/29/2018 08:57 AM, Jonas Bonn wrote:
> After setting up the request structure, qmi_service_send makes no
> further use of the 'param' and 'service' fields of the service_send_data
> structure.  This patch removes those fields and frees 'param'
> immediately after the request has been allocated and the parameter data
> thereby copied into the send buffer.
> ---
>   drivers/qmimodem/qmi.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============8311908367352868451==--

