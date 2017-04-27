Content-Type: multipart/mixed; boundary="===============9115374126690993871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] hfp_hf: Fix not creating modem during NewConnection
Date: Thu, 27 Apr 2017 13:28:14 -0500
Message-ID: <5a661f21-e36c-695f-ffdc-78ba98af49d1@gmail.com>
In-Reply-To: <20170427125507.19335-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9115374126690993871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On 04/27/2017 07:55 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In case the UUIDs are not updated, or are still being resolved, when
> Paired property changes a modem will never be registered.

I can sort of see the 'still being resolved' issue.  But what is the =

'not updated' part?

>
> In order to fix this problem allow modems to be registered directly
> during NewConnection.

Wouldn't it be better to track the UUIDs property changes as well and =

register the modem when this changes?  Otherwise the AG side might be =

able to trigger a connection, but not vice-versa.

> ---
>  plugins/hfp_hf_bluez5.c | 193 +++++++++++++++++++++++++-----------------=
------
>  1 file changed, 102 insertions(+), 91 deletions(-)
>

Regards,
-Denis


--===============9115374126690993871==--

