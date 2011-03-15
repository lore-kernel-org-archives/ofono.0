Content-Type: multipart/mixed; boundary="===============6315168421318460770=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: RE: [PATCH v2] call-forwarding: fix for showing call forwarding states
Date: Tue, 15 Mar 2011 16:15:22 +0200
Message-ID: <1300198522.12589.8.camel@jussi-desktop>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802E70E4E@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6315168421318460770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On Tue, 2011-03-15 at 15:59 +0200, Arun.Ravindran(a)elektrobit.com wrote:

> What is the "removal of CALL_FORWARDING_ALL_CONDITIONAL worked little
> bit oddly without break" issue?

Oh, nothing major. I tried to refer to the stuff in next sentence:
"Results visible to API were correct but they were result of one failed
query and querying all states, with current solution there is no failed
query anymore" =


Denis commented to earlier version of this patch that it could not work
as I proposed. I commented back that in my testings it seemed to work,
but I noticed later that it worked somewhat "oddly" and I fixed that by
changing the range of accepted queries in query methods and adding the
break and separate query_next and query_end for
CALL_FORWARDING_ALL_CONDITIONAL as he was proposing.

Br,
-Jussi.


> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



--===============6315168421318460770==--

