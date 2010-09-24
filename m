Content-Type: multipart/mixed; boundary="===============1151219514765603680=="
MIME-Version: 1.0
From: rajyalakshmi bommaraju <rajyalakshmi.bommaraju@intel.com>
Subject: Re: Please comment on callhistory API
Date: Fri, 24 Sep 2010 15:00:00 -0700
Message-ID: <4C9D1F60.6090005@intel.com>
In-Reply-To: <1285291025.20811.102.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1151219514765603680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,
I have incorporated your feedback into the document . Please let me know =

if anything needs to be changed.

Thanks
Raji

			Callhistory Adapter-Agent


CallHistory is a built in plugin for ofono. It uses CallHistoryAgent api =

exposed by client to push voice call history information. =

CallHistoryAgent api is a service interface exposed by client over dbus. =

Plugin exposes CallHistory interface that CallHistoryAgent registers and =

unregisters with. if the CallHistoryAgent registers with CallHistory =

then plugin pushes the history information to the agent soon as it =

receives from ofono, otherwise it caches the data in a disk file until =

agent registers, once agent registers plugin will read the data from the =

disk file and pushes all the records to it.

CallHistory:

it is going to register and unregister the agent. It calls the methods =

on the agent for delivering history information whent the agent is up =

and running. The history record will be written to the disk if agent =

method returns error or if the agent is not running.


CallHistory hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Service : org.ofono
Interface : org.ofono.CallHistory
Object path : [variable prefix]/{modem0,modem1,...}/CallHistory

Methods 	void RegisterAgent (objectpath)

			RegisterAgent method registers the agent object path. Methods on this =

			agent will be called if history needs to push data.

			Possible Errors: [service].Error.InvalidArguments
			[service].Error.InvalidFormat
			[service].Error.InUse

		void UnregisterAgent (objectpath)

			UnregisterAgent method unregister the already registered agent object pa=
th.

			Possible Errors: [service].Error.InvalidArguments
			[service].Error.InvalidFormat
			[service].Error.InUse

CallHistoryAgent hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Service Name : Unique Name
Interface : org.ofono.CallHistoryAgent
Objectpath : Freely definable

Methods 	void SendHistory( array{dict})

			This method gets called by ofono to deliver an array of records. Each =

			record is represented as a dictionary, all the dict properties are =

			described in the "Properties" section.

			Possible Errors: [service].Error.Unsuccessful

		void Release()
			Cleans up agent, assumes that agent is already unregistered, so not =

			needed to unregister.

Properties
=3D=3D=3D=3D=3D=3D=3D
		integer Uid [Read Only]
			Integer representing the unique id of the history record

		string Calltype [Read Only]
			string representing the call type. Call type can be one of the following =

			three alternatives
			"outgoing" - it is an outgoing call
			"incoming" - it is an incoming call
			"missed" - it is a missed call

		string LineIdentification [Read Only]
			string representing the LineIdentification , for outgoing call it is the =

			phone number dialed. For Incoming call it is the CLIP, or COLP if =

			received by the underlying implementation.

		string StartTime [Read Only]
			String representing start time of the call

		string EndTime [Read Only]
			String representing end time of the call


--===============1151219514765603680==--

