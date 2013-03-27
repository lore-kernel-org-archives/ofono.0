Content-Type: multipart/mixed; boundary="===============2253939524371575031=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 1/3] hfpmodem: Retry AT+CLCC request after outgoing
 callsetup
Date: Wed, 27 Mar 2013 00:05:53 -0500
Message-ID: <51527E31.4090604@gmail.com>
In-Reply-To: <da43e0125ebcdf570d287d3d84fbf139cc2bfa9e.1360663430.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2253939524371575031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Timo,

On 02/13/2013 02:36 AM, Timo Mueller wrote:
> From: Timo Mueller<timo.mueller@bmw-carit.de>
>
> Currently the list of current calls is requested right after an
> outgoing callsetup has been reported by the AG device. If the AG
> device updates the list after reporting the callsetup the +CLCC
> response may not contain the new call and it is not registered
> with oFono.
>
> In this case AT+CLCC should be requested again once after a small
> delay.
>
> AT sequence that exhibited the failure (AG device was a Nokia N9
> placing an outgoing call)
>
> <  \r\n+CIEV: 5,2\r\n
>> AT+CLCC\r
> <  \r\nOK\r\n
> <  \r\n+VGS=3D7\r\n
> <  \r\n+VGM=3D7\r\n
> <  \r\n+CIEV: 5,3\r\n
> <  \r\n+CIEV: 4,1\r\n
> <  \r\n+CIEV: 5,0\r\n
> ---
> v3: Splitted clcc_poll_cb to avoid parsing of the clcc result twice
> when a dialing call was found in the response.

I'm fine with this version, however I still would prefer that we hid the =

poll-for-dialing logic behind the N9 vendor quirk.

Regards,
-Denis

--===============2253939524371575031==--

