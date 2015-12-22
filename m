Content-Type: multipart/mixed; boundary="===============6903788838263441910=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] network: Fix use-after-free caused by Scan() in poor
 reception.
Date: Tue, 22 Dec 2015 10:23:22 -0600
Message-ID: <567978FA.2050006@gmail.com>
In-Reply-To: <5678F735.9000002@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6903788838263441910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

 >> I'm not sure this is the right fix.  This will result in subsequent
>> API calls to return inconsistent information related to the network
>> operator.  For example, NetworkRegistration.Name,
>> NetworkRegistration.MobileNetworkCode,
>> NetworkRegistration.MobileCountryCode will be omitted.
>>
>> Can we make sure that the current operator is not destroyed /
>> unregistered in this particular situation?
> It may be possible but I could not figure out a way to do that. So I did
> it like this to at least prevent the resulting SIGSEGV.

Understood, but this fix is not really acceptable.

In update_operator_list(), the old operators (that weren't found during =

Scan()) are unregistered.

         for (o =3D netreg->operator_list; o; o =3D o->next)
                 network_operator_dbus_unregister(netreg, o->data);

One way of accomplishing the above, would be to detect that =

netreg->current_operator is being removed and handle that appropriately. =

  E.g. by moving it from the old list to the new list.

Regards,
-Denis



--===============6903788838263441910==--

