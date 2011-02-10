Content-Type: multipart/mixed; boundary="===============8158910099426686251=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/3] call-barring: removed +CSSI type SS notifications
Date: Wed, 09 Feb 2011 21:04:54 -0600
Message-ID: <4D5355D6.9000503@gmail.com>
In-Reply-To: <7f7cc862a685786b014377e6e97c789d8d65666b.1297244230.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8158910099426686251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras

On 02/09/2011 04:33 AM, Andras Domokos wrote:
> ---
>  src/call-barring.c |   74 ----------------------------------------------=
------
>  1 files changed, 0 insertions(+), 74 deletions(-)
> =

> diff --git a/src/call-barring.c b/src/call-barring.c
> index 649826e..84ed277 100644
> --- a/src/call-barring.c
> +++ b/src/call-barring.c
> @@ -58,9 +58,6 @@ struct ofono_call_barring {
>  	int ss_req_lock;
>  	struct ofono_ssn *ssn;

You forgot to remove this part in your patch.  I applied your patch and
fixed this in a follow on patch.

>  	struct ofono_ussd *ussd;
> -	unsigned int incoming_bar_watch;
> -	unsigned int outgoing_bar_watch;
> -	unsigned int ssn_watch;
>  	unsigned int ussd_watch;
>  	const struct ofono_call_barring_driver *driver;
>  	void *driver_data;

Regards,
-Denis

--===============8158910099426686251==--

