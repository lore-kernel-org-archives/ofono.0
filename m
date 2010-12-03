Content-Type: multipart/mixed; boundary="===============6806052284134683929=="
MIME-Version: 1.0
From: John.Mathew@elektrobit.com
Subject: RE: [PATCH] voicecall: Add EmergencyCall property.
Date: Fri, 03 Dec 2010 10:00:36 +0200
Message-ID: <FE1DB9979BF5A743BEB836613423CAD8012C9C95@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1289494917.3266.64.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6806052284134683929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


>
>> This was a question open for discussion. What would be the =

>appropriate property name?
>
>As per my understanding, this property is only to provide the =

>Emergency call indication to the application side, so that =

>applications can display a different UI compared to the normal =

>UI. In this case, I think the property name "Emergency" is enough. =

>
>Since this is a property for the call, the following fits as =

>well. We can remove the existing multiparty property and add =

>it to the new property.
>
>string Type [readonly]
>       Contains the Type of the current call.
>
>       The Values can be:
>               "Normal"
>               "Emergency"
>		   "Data"
>	         "Multiparty"	=

>
>Let me know your opinion on this.
> =

                         =

Any comments?


--===============6806052284134683929==--

