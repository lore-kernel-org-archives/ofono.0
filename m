Content-Type: multipart/mixed; boundary="===============4388281738318000364=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v3 00/13] Add support for BlueZ 5 Profile1 API to dundee
Date: Tue, 02 Apr 2013 15:12:23 +0200
Message-ID: <515AD937.8000606@monom.org>
In-Reply-To: <CAG7KCRHHKkd6jStROGh+-6R8ff-6-vsj+E8E8D0J4kLm++djKg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4388281738318000364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

[sorry for the late response, was on vacation]

On 03/25/2013 03:43 PM, Paulo Borges wrote:
> Hi Daniel,
>
> On Sun, Mar 24, 2013 at 9:31 AM, Daniel Wagner <wagi@monom.org
> <mailto:wagi@monom.org>> wrote:
>
>     Hi Paulo,
>
>     I have pushed all patches except patch #3. "dun_gw: Add BlueZ 5
>     version" from Fr=C3=A9d=C3=A9ric just added recently the definition f=
or
>     DUN_GW_UUID. Obviously, I needed to update your patches to use
>     DUN_GW_UUID instead of DUN_UUID. The bluez4.c file also uses
>     DUN_GW_UUID as identifier.
>
>     Thanks a lot,
>     daniel
>
>
> Actually, DUN profile is "asymmetric": it doesn't have an UUID for each
> role, they share the same UUID [1]. The only way to distinguish the
> current role is to specify it when registering the profile with
> bt_register_profile_with_role function.
>
> Specifying the role when registering a DUN profile is important because
> only GW should expose a SDP record.
>
> [1]
> https://www.bluetooth.org/Technical/AssignedNumbers/service_discovery.htm

I see. The thing I wanted to avoid is to have twice a define for the =

same value. In the end the way how the define is used (as you have =

described above) is essential.

cheers,
daniel


--===============4388281738318000364==--

