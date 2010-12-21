Content-Type: multipart/mixed; boundary="===============6566657513400023663=="
MIME-Version: 1.0
From: Tikander Petteri <petteri.tikander@ixonos.com>
Subject: RE: TODO: Network updating the emergency number list
Date: Tue, 21 Dec 2010 18:21:09 +0200
Message-ID: <1292948469.29886.224.camel@r82e1wc.ixonos.local>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702DE38C0@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6566657513400023663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh and Denis,

If we are in area with multiple networks (so multiple MCCs), lets pass
only received emergency-list from the servicing network, where ME is
registered to, and discard possible notifications from other network's
emergency-number notifications:

TS 22101, ch. 10.1
"The UE shall regard these emergency numbers as valid in that country
only (as identified by the MCC) and shall discard them when a new
country is entered."

One think in one of those emails focusing on this discussion (Waldo's
comment) was:
>The modem will typically already analyze the new emergency-numbers,
>filter out the ones that are not applicable and merge the numbers from
>the various sources in the right priority....

My idea first in analyzing was to compare new emergency numbers with
already sent emergency numbers (default-list/SIM EFecc-list), and send
those up, if new emergency numbers compared to the old already sent ones
were received. OK, probably in many cases modems will do this analyze
itself, and send only new ones to the oFono. I don't know if it's
actually dangerous, if oFono passes all network emergency numbers
received from the modem (filtered or not by the modem). OK, then it's
possible that some ECCs are reported twice. On the other hand, network
ECCs (if MCC matches) should always be valid ones, suitable numbers, in
spite of, where mobile is located. So it should be valid to acknowledge
those new numbers always to UI in spite of, what numbers are sent to UI
in initialization phase.

Perhaps then the only thing to be analyzed could be that country-code
item.

Network downloaded emergency number-list can also contain emergency call
type in the category-field (for instance "Police", "Ambulance"...). This
kind of information is not included for example in SIM EFecc-file, so
Emergency-number property returns in this moment just the ECC-number
without the category. What do you think, should this also be included in
the Emergency-property?

Br, Petteri


On Fri, 2010-12-17 at 13:09 -0800, Rajesh.Nagaiah(a)elektrobit.com wrote:
> Hi Denis,
>
> > Hi Rajesh,
> >
> > >> Can you do me a favor and investigate what oFono's
> > behavior should be
> > >> if we receive emergency numbers that are not relevant to the
> > >> currently registered PLMN?  We should also update the task
> > >> description with the above.
> > >
> > > The ECC list downloaded from the network are country
> > specific ones, so
> > > this ECC list usually can be notified by any available network not
> > > necessarily by the serving network. The ECC list thats
> > downloaded from
> > > the serving network has to be reset when the phone registers in
> > > another network with a different MCC ( not MNC ), as this
> > ECC list is
> > > country specific not operator specific.
> > >
> >
> > Sounds reasonable.  Is this relevant only when the ME is
> > registered with the IMSI known or also when the SIM is not
> > present / PIN not entered?
>
> Only when the SIM/USIM is present.
>
> > For these cases, what happens when we're in an area with
> > multiple networks with multiple MCCs.
>
> Good question :)
>
> > Final question, is there a spec that describes this behavior?
>
> 3GPP TS 22.101 Section 10
>
> BR,
> Rajesh
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============6566657513400023663==--

