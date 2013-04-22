Content-Type: multipart/mixed; boundary="===============5789468411484360632=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 1/3] hfp_ag_bluez5: Create a hash to store connections
Date: Mon, 22 Apr 2013 03:55:50 -0500
Message-ID: <5174FB16.8090504@gmail.com>
In-Reply-To: <1366409945-31401-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5789468411484360632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/19/2013 05:19 PM, Paulo Borges wrote:
> We need to store active connections so we can disconnect them at
> RequestDisconnect().
>
> When we remove a connection from the hash, we also close it.
> ---
>   plugins/hfp_ag_bluez5.c |   15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Patch has been applied, thanks.

Regards,
-Denis


--===============5789468411484360632==--

