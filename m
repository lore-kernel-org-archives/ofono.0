Content-Type: multipart/mixed; boundary="===============4115058682007331117=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Retrieve ofono_sim_password_type
Date: Fri, 08 Apr 2011 14:38:02 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802EF09AA@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <65D0035E6914AC478A46CFE3E20C392601E9F725@snch1xch53.sicpa-net.ads>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4115058682007331117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Christophe,	=


>	Hi,
>
>	I need to map ofono_sim_password_type according to h24 AT
command manual.
>
>	Can somebody check if I mapped correctly enum with documentation
definition.
>
>	OFONO_SIM_PASSWORD_SIM_PIN       : PIN attempts
>
>	OFONO_SIM_PASSWORD_SIM_PUK,     : PUK attempts
>
>	OFONO_SIM_PASSWORD_SIM_PIN2,    : PIN2 attempts
>
>	OFONO_SIM_PASSWORD_SIM_PUK2,    : PUK2 attempts
>
>	OFONO_SIM_PASSWORD_PHNET_PIN,   : NETWORK PERSONALIZATION PIN
attempts
>
>	OFONO_SIM_PASSWORD_PHNET_PUK,   : NETWORK PERSONALIZATION PUK
attempts
>
>	OFONO_SIM_PASSWORD_PHNETSUB_PIN,: NETWORK SUBSET PERSONALIZATION
PIN attempts
>
>	OFONO_SIM_PASSWORD_PHNETSUB_PUK,: NETWORK SUBSET PERSONALIZATION
PUK attempts
>
>	OFONO_SIM_PASSWORD_PHSP_PIN,    : SERVICE PROVIDER
PERSONALIZATION PIN attempts
>
>	OFONO_SIM_PASSWORD_PHSP_PUK,    : SERVICE PROVIDER
PERSONALIZATION PUK attempts
>
>	OFONO_SIM_PASSWORD_PHCORP_PIN,  : CORPORATE PERSONALIZATION PIN
attempts
>
>	OFONO_SIM_PASSWORD_PHCORP_PUK,  : CORPORATE PERSONALIZATION PUK
attempts
>
>	OFONO_SIM_PASSWORD_PHFSIM_PIN,  : SIM PERSONALIZATION PIN
attempts
>
>	OFONO_SIM_PASSWORD_PHFSIM_PUK,  : SIM PERSONALIZATION PUK
attempts

enum value is based on the 27.007 section 8.3 <code> values. If the h24
values are as per
27.007 specification, then its correct.

Atleast based on the description, mapping seems to be correct.

Regards,
Jeevaka

--===============4115058682007331117==--

