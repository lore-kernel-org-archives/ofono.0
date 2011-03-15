Content-Type: multipart/mixed; boundary="===============1629287491011031596=="
MIME-Version: 1.0
From: Arun.Ravindran@elektrobit.com
Subject: RE: [PATCH v2] call-forwarding: fix for showing call forwarding states
Date: Tue, 15 Mar 2011 15:59:30 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802E70E4E@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1300197066-12538-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1629287491011031596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,
 =


> Subject: [PATCH v2] call-forwarding: fix for showing call =

> forwarding states
> =

> ---
> =

> Hi, =

> =

> Here is a updated version of the call forwarding state fix. I =

> changed the indentations and zero comparisons according the =

> feedback from Denis. Also I decided to add data freeing in =

> set_property_callback and break in cf_ss_control as commented =

> and not as I speculated at first. I noticed in further =

> testing that removal of CALL_FORWARDING_ALL_CONDITIONAL =

> worked little bit oddly without break. Results visible to API =

> were correct but they were result of one failed query and =

> querying all states, with current solution there is no failed =

> query anymore. =

> =


What is the "removal of CALL_FORWARDING_ALL_CONDITIONAL worked little
bit oddly without break" issue?


Regards
Arun

--===============1629287491011031596==--

