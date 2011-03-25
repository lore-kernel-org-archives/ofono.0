Content-Type: multipart/mixed; boundary="===============5333433055386396381=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: Re: [PATCH] gatserver: add v250 ATL and ATM commands
Date: Fri, 25 Mar 2011 09:16:50 +0100
Message-ID: <4D8C4F72.9060305@linux.intel.com>
In-Reply-To: <4D8B8D76.3000507@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5333433055386396381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/24/2011 07:29 PM, Denis Kenzior wrote:
> Hi Olivier,
>
>> +static void at_l_cb(GAtServer *server, GAtServerRequestType type,
>> +			GAtResult *result, gpointer user_data)
>> +{
>> +	s_template_cb(type, result, server,&server->v250.s5, "L", 0, 3);
> Copy paste error?  I presume you mean v250.l here
>
> Regards,
> -Denis
Ooooops... you re right... sorry
Olivier

--===============5333433055386396381==--

