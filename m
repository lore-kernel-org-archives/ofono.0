Content-Type: multipart/mixed; boundary="===============2659019678175915947=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [RFC 7/7] doc: Add new property to call forwarding
Date: Fri, 26 Nov 2010 08:55:46 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C08204@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTi=GFwQUxCD5uFdwZsQvfTk0h6hUO-6oSZhS_akK@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2659019678175915947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Sankar,

> As per the specification, querying of group of supplementary services
is not allowed. Do you propose a solution where core queries all the
three call forwardings namely =

> CF busy, CF Not Reachable, CF noreply and updating the clients with
the status using the above property after receiving the status for all
the three? =


Query logic is already taken care in the oFono core. Check the
get_query_next_cf_cond function in src/call-forwarding.c.
"VoiceUnconditionalStatus" property is only about the VoiceUnconditional
call forwarding rule. VoiceUnconditional status can be also known from
the sim files EFcfis and EFcphs-cff(Note: Files are optional). This
patch reads the SIM files(if present) and updates the status. Patch also
takes care of updating the sim files when the user activates
VoiceUnconditional call forwarding rule.

Regards,
Jeevaka

--===============2659019678175915947==--

