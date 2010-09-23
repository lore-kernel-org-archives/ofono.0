Content-Type: multipart/mixed; boundary="===============2015330193157630862=="
MIME-Version: 1.0
From: rajyalakshmi bommaraju <rajyalakshmi.bommaraju@intel.com>
Subject: Please comment on callhistory API
Date: Thu, 23 Sep 2010 13:28:21 -0700
Message-ID: <4C9BB865.4070301@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2015330193157630862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
Attached Callhistory API , please send me your feedback on it, I will =

extend this include SmsHistory once callhistory API looks good.

Thanks
Raji


							Callhistory Adapter-Agent


	CallHistoryAdapter is a built in plugin for ofono. It uses CallHistoryAgen=
t api exposed by dialer or client daemon to push voice call history informa=
tion to client. CallHistoryAgent api is an service interface exposed by cli=
ent over dbus. Plugin exposes CallHistoryAdapter interface that CallHistory=
Agent registers and unregisters with. if the CallHistoryAgent registers wit=
h Adapter then plugin pushes the history information to dialer as soon as i=
t receives from ofono, otherwise it caches the data in a disk file until ag=
ent registers, once agent registers plugin will read the data from the disk=
 file and pushes all the records to it.


Adapter: =


it is going to register and unregister the agent. Calls the methods on the =
agent for delivering history information whent the agent is up and running.=
 If the record cant be delivered that means agent method returns an error t=
hen it will be written to the disk file. If the agent is down it will persi=
st history record in disk file.


CallHistoryAdapter hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Service 	: org.ofono
Interface	: org.ofono.CallHistoryAdapter
Object path	: freely definable

Methods		void RegisterAgent (objectpath)  =


			RegisterAgent method registers the agent object path. Methods on this ag=
ent will be called if history needs to push data.  =


			Possible Errors: [service].Error.InvalidArguments
					 [service].Error.InvalidFormat
					 [service].Error.InUse

		void UnregisterAgent (objectpath) =


			UnregisterAgent method unregister the already registered agent object pa=
th.

			Possible Errors: [service].Error.InvalidArguments
					 [service].Error.InvalidFormat
					 [service].Error.InUse


CallHistoryAgent hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Service Name	: Unique Name
Interface	: org.ofono.CallHistoryAgent
Objectpath	: Freely definable

Methods		void SendHistory(array {struct {uint32,uint32,uint8,uint32,uint32}=
 }) =


			This method gets called by ofono to deliver one record of voice call his=
tory.
		=

			Possible Errors: [service].Error.Unsuccessful

		void SendCachedHistory(array {struct {uint32,uint32,uint8,uint32,uint32} =
})

			This method gets called by the ofono when CallHistoryAgent starts runnin=
g. =

			It delivers all the history records as an array of structures.

			Possible Errors: [service].Error.Unsuccessful

		void Release() =

			Cleans up agent, assumes that agent is already unregistered, so not need=
ed to unregister. =


CallHistory Record =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

CallHistoryRecord {
		uint32	uid;
		uint8	voicecalltype;
		char	lineid[20];
		uint32	starttime;
		uint32	endtime;
}

voicecalltype {
	outgoing =3D 0,
	incoming =3D 1,
	missed =3D 2
}
	=09

--===============2015330193157630862==--

