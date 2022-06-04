cd /repo

export VERSION_INFO="$(/tools/dotnet-gitversion)"

echo "Version Info:"
echo "--------------------------------------------------------------------------------------"
echo $VERSION_INFO
echo "--------------------------------------------------------------------------------------"

export ASSEMBLY_SEM_VERSION="$(echo "$VERSION_INFO" | jq -r .AssemblySemVer)"
export ASSEMBLY_SEM_FILE_VERSION="$(echo "$VERSION_INFO" | jq -r .AssemblySemFileVer)"
export INFORMATIONAL_VERSION="$(echo "$VERSION_INFO" | jq -r .InformationalVersion)"
export SEM_VERSION="$(echo "$VERSION_INFO" | jq -r .SemVer)"
export FULL_SEM_VERSION="$(echo "$VERSION_INFO" | jq -r .FullSemVer)"
export COMMIT_HASH="$(echo "$VERSION_INFO" | jq -r .Sha)"
export DOCKER_TAG="$(echo "$FULL_SEM_VERSION" | sed 's/+/-/')"

echo "Assembly Sem Version:       $ASSEMBLY_SEM_VERSION"
echo "Assembly Sem File Version:  $ASSEMBLY_SEM_FILE_VERSION"
echo "Informational Version:      $INFORMATIONAL_VERSION"
echo "Sem Version:                $SEM_VERSION"
echo "Full Sem Version:           $FULL_SEM_VERSION"
echo "Docker Tag:                 $DOCKER_TAG"
echo
echo "Git Commit Hash:            $COMMIT_HASH"
echo

touch version.txt
echo $SEM_VERSION >> version.txt
