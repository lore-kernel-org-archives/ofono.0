Content-Type: multipart/mixed; boundary="===============7452355618407276960=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 1/2] stk: provide access technology info
Date: Fri, 19 Nov 2010 14:04:11 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473306473C1@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802C076BD@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7452355618407276960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>
>As per the ETSI TS 102 223 specification 4.12 section, when the SAT
>issues Provide Local Information proactive command with Access
>Technology(0x06) as the command qualifier, we should provide the current
>access technology . So, as per my understanding we need to use
>netreg->technology.
>
>> void __ofono_netreg_set_base_station_name(struct ofono_netreg *netreg,
>> 						const char *name);
>> +unsigned int __ofono_netreg_get_tech(struct ofono_netreg *netreg);
>
>Empty line needed between __ofono_netreg_set_base_station_name and
>__ofono_netreg_get_tech

I think you're right. I'm not quite clear about the difference. Could you h=
elp me clarify several questions? =

Does it mean COPS only returns current available access technology, while C=
REG returns current connected access technology? =

And if netreg->technology is used, what should be returned once the multipl=
e access technologies are requested? It seems oFono only supports one conne=
cted technology.
In which situation we can connect to multiple access technologies simultane=
ously?


Regards,
-Yang

--===============7452355618407276960==--

