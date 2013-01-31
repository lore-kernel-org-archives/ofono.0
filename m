Content-Type: multipart/mixed; boundary="===============6279678519605358670=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 1/2] hfp_hf_bluez5: Improve Proxy property changed
 handling
Date: Wed, 30 Jan 2013 21:33:11 -0600
Message-ID: <5109E5F7.6080105@gmail.com>
In-Reply-To: <1359563056-24294-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6279678519605358670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/30/2013 10:24 AM, Claudio Takahasi wrote:
> This patch removes unnecessary GDBusProxy object access when property
> changed is triggered. The property name and the argument iterator is
> informed in the function callback.
> ---
>   plugins/hfp_hf_bluez5.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============6279678519605358670==--

