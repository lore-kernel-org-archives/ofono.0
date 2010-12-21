Content-Type: multipart/mixed; boundary="===============3071611169707652185=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: TODO: Network updating the emergency number list
Date: Tue, 21 Dec 2010 14:14:00 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702DE3D12@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <4D1107E6.4000403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3071611169707652185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis / Petteri,
 =

> > Network downloaded emergency number-list can also contain emergency =

> > call type in the category-field (for instance "Police", =

> > "Ambulance"...). This kind of information is not included =

> for example =

> > in SIM EFecc-file, so Emergency-number property returns in =

> this moment =

> > just the ECC-number without the category. What do you think, should =

> > this also be included in the Emergency-property?
> =

> I believe the EFecc described in 31.102 also contains the =

> category information.  So we can certainly change the API to =

> provide this information or an empty string if unknown.  =

> However, since the category information is a bitmap, mapping =

> this to an API in a nice manner can be quite challenging.  =

> Feel free to propose something.

Is the emergency number category really used on the AP SW side ? =

All we do is to check the number against the ECC list to see its =

going to use the dedicated emergency services channel in the radio =

interface for that call or not, irrespective of the category type.
If we are going to have an UI thats going to list ECC numbers and its =

corresponding category, then this information is useful, but I have
never seen such UI in other platforms as well.

BR,
Rajesh

--===============3071611169707652185==--

