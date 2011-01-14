Content-Type: multipart/mixed; boundary="===============2803092592451317679=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH v3 2/2] plugins: add ctm create to ifx plugin
Date: Fri, 14 Jan 2011 11:30:56 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4140E09CB@008-AM1MPN1-001.mgdnok.nokia.com>
In-Reply-To: <1294964100.3873.109.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2803092592451317679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 14 Jan 2011, Marcel Holtmann wrote:
>>  #include <drivers/atmodem/atutil.h>
>> @@ -700,6 +701,7 @@ static void ifx_post_sim(struct ofono_modem
>*modem)
>>
>>  	DBG("%p", modem);
>>
>> +	ofono_ctm_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
> =

> so no emergency calls with CTM are possible? Or do we have to
> potentially also handle that?

a very good point! So yes, TTY-enabled emergency calls are definitely
needed. And in fact, that's probably one of the _most_ important
use-cases for TTY there is (as you cannot send an SMS to the emergency =

center [1]).

[1] well, actually there are specs for this, and even trials, but =

    it'll take ages before this gets widely deployed



--===============2803092592451317679==--

